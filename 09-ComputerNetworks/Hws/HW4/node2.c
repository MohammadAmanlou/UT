#include <stdio.h>

struct rtpkt
{
  int sourceid;   /* id of sending router sending this pkt */
  int destid;     /* id of router to which pkt being sent
                     (must be an immediate neighbor) */
  int mincost[4]; /* min cost to node 0 ... 3 */
};


extern int TRACE;
extern int YES;
extern int NO;
extern float clocktime;
#define INFINITY 999

struct distance_table
{
  int costs[4][4];
} dt2;

void printdt2(struct distance_table *dtptr);
void tolayer2(struct rtpkt pkt);


int direct_costs2[4] = {3, 1, 0, 2};
static int neighbor_reported_costs[4][4];

int get_min_cost2(int dest)
{
  if (dest == 2)
    return 0;

  int min = INFINITY;

  int neighbors[] = {0, 1, 3};
  for (int k = 0; k < 3; k++)
  {
    int neighbor = neighbors[k];

    int cost = dt2.costs[dest][neighbor];

    if (cost < min)
      min = cost;
  }
  return min;
}

void send_dt2_to_neighbors()
{
  struct rtpkt pkt;
  pkt.sourceid = 2;

  for (int i = 0; i < 4; i++)
  {
    pkt.mincost[i] = get_min_cost2(i);
  }

  if (TRACE > 0)
    printf("t=%.3f node2: sending [%d, %d, %d, %d] to neighbors.\n",
           clocktime, pkt.mincost[0], pkt.mincost[1], pkt.mincost[2], pkt.mincost[3]);

  int neighbors[] = {0, 1, 3};
  for (int i = 0; i < 3; i++)
  {
    pkt.destid = neighbors[i];
    tolayer2(pkt);
  }
}

void rtinit2()
{
  for (int i = 0; i < 4; i++)
  {
    for (int j = 0; j < 4; j++)
    {
      dt2.costs[i][j] = INFINITY;
      neighbor_reported_costs[i][j] = INFINITY;
    }
  }

  dt2.costs[0][0] = direct_costs2[0];
  dt2.costs[1][1] = direct_costs2[1];
  dt2.costs[3][3] = direct_costs2[3];

  neighbor_reported_costs[2][0] = INFINITY;
  neighbor_reported_costs[0][0] = 0;
  neighbor_reported_costs[2][1] = INFINITY;
  neighbor_reported_costs[1][1] = 0;
  neighbor_reported_costs[2][3] = INFINITY;
  neighbor_reported_costs[3][3] = 0;

  printf("t=%.3f rtinit2: table initialized.\n", clocktime);
  printdt2(&dt2);

  send_dt2_to_neighbors();
}

void rtupdate2(rcvdpkt) struct rtpkt *rcvdpkt;
{
  int src = rcvdpkt->sourceid;
  int changed = 0;

  int old_min_costs[4];
  for (int i = 0; i < 4; i++)
    old_min_costs[i] = get_min_cost2(i);

  for (int i = 0; i < 4; i++)
  {
    neighbor_reported_costs[i][src] = rcvdpkt->mincost[i];
  }

  for (int i = 0; i < 4; i++)
  {
    int new_cost = direct_costs2[src] + rcvdpkt->mincost[i];
    if (new_cost > INFINITY)
      new_cost = INFINITY;

    dt2.costs[i][src] = new_cost;
  }

  for (int i = 0; i < 4; i++)
  {
    if (get_min_cost2(i) != old_min_costs[i])
    {
      changed = 1;
      break;
    }
  }

  printf("t=%.3f rtupdate2: received [%d, %d, %d, %d] from node %d and mincosts %s\n",
         clocktime,
         rcvdpkt->mincost[0], rcvdpkt->mincost[1], rcvdpkt->mincost[2], rcvdpkt->mincost[3],
         src,
         changed ? "updated" : "did not update");

  printdt2(&dt2);

  if (changed)
  {
    send_dt2_to_neighbors();
  }
}

void printdt2(dtptr) struct distance_table *dtptr;

{
  printf("                via     \n");
  printf("   D2 |    0     1    3 \n");
  printf("  ----|-----------------\n");
  printf("     0|  %3d   %3d   %3d\n", dtptr->costs[0][0],
         dtptr->costs[0][1], dtptr->costs[0][3]);
  printf("dest 1|  %3d   %3d   %3d\n", dtptr->costs[1][0],
         dtptr->costs[1][1], dtptr->costs[1][3]);
  printf("     3|  %3d   %3d   %3d\n", dtptr->costs[3][0],
         dtptr->costs[3][1], dtptr->costs[3][3]);
}

void linkhandler2(linkid, newcost) int linkid, newcost;
{
  int old_min_costs[4];
  for (int i = 0; i < 4; i++)
    old_min_costs[i] = get_min_cost2(i);

  direct_costs2[linkid] = newcost;

  for (int i = 0; i < 4; i++)
  {
    int cost_via_neighbor = neighbor_reported_costs[i][linkid];

    if (cost_via_neighbor == INFINITY)
    {
      dt2.costs[i][linkid] = INFINITY;
    }
    else
    {
      int total = newcost + cost_via_neighbor;
      if (total > INFINITY)
        total = INFINITY;
      dt2.costs[i][linkid] = total;
    }
  }

  int changed = 0;
  for (int i = 0; i < 4; i++)
  {
    if (get_min_cost2(i) != old_min_costs[i])
    {
      changed = 1;
      break;
    }
  }

  printf("t=%.3f linkhandler2: cost to link %d changed to %d. mincosts %s\n",
         clocktime, linkid, newcost, changed ? "updated" : "did not update");

  printdt2(&dt2);

  if (changed)
  {
    send_dt2_to_neighbors();
  }
}