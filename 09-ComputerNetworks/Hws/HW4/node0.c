#include <stdio.h>

struct rtpkt
{
  int sourceid;   /* id of sending router sending this pkt */
  int destid;     /* id of router to which pkt being sent
                     (must be an immediate neighbor) */
  int mincost[4]; /* min cost to node 0 ... 3 */
};

void tolayer2(struct rtpkt pkt);

extern int TRACE;
extern int YES;
extern int NO;
extern float clocktime;
#define INFINITY 999

struct distance_table
{
  int costs[4][4];
} dt0;

void printdt0(struct distance_table *dtptr);
void tolayer2(struct rtpkt pkt);

int direct_costs0[4] = {0, 1, 3, 7};
static int neighbor_reported_costs[4][4];

int get_min_cost0(int dest)
{
  if (dest == 0)
    return 0;
  int min = INFINITY;

  int neighbors[] = {1, 2, 3};
  for (int k = 0; k < 3; k++)
  {
    int neighbor = neighbors[k];

    /* هزینه مسیر از طریق این همسایه */
    int cost = dt0.costs[dest][neighbor];

    if (cost < min)
      min = cost;
  }
  return min;
}

void send_dt0_to_neighbors()
{
  struct rtpkt pkt;
  pkt.sourceid = 0;

  for (int i = 0; i < 4; i++)
  {
    pkt.mincost[i] = get_min_cost0(i);
  }

  if (TRACE > 0)
    printf("t=%.3f node0: sending [%d, %d, %d, %d] to neighbors.\n",
           clocktime, pkt.mincost[0], pkt.mincost[1], pkt.mincost[2], pkt.mincost[3]);

  int neighbors[] = {1, 2, 3};
  for (int i = 0; i < 3; i++)
  {
    pkt.destid = neighbors[i];
    tolayer2(pkt);
  }
}

void rtinit0()
{
  for (int i = 0; i < 4; i++)
  {
    for (int j = 0; j < 4; j++)
    {
      dt0.costs[i][j] = INFINITY;
      neighbor_reported_costs[i][j] = INFINITY;
    }
  }

  dt0.costs[1][1] = direct_costs0[1];
  dt0.costs[2][2] = direct_costs0[2];
  dt0.costs[3][3] = direct_costs0[3];

  neighbor_reported_costs[0][1] = INFINITY;
  neighbor_reported_costs[1][1] = 0;
  neighbor_reported_costs[0][2] = INFINITY;
  neighbor_reported_costs[2][2] = 0;
  neighbor_reported_costs[0][3] = INFINITY;
  neighbor_reported_costs[3][3] = 0;

  printf("t=%.3f rtinit0: table initialized.\n", clocktime);
  printdt0(&dt0);

  send_dt0_to_neighbors();
}

void rtupdate0(rcvdpkt) struct rtpkt *rcvdpkt;
{
  int src = rcvdpkt->sourceid;
  int changed = 0;

  int old_min_costs[4];
  for (int i = 0; i < 4; i++)
    old_min_costs[i] = get_min_cost0(i);

  for (int i = 0; i < 4; i++)
  {
    neighbor_reported_costs[i][src] = rcvdpkt->mincost[i];
  }

  for (int i = 0; i < 4; i++)
  {
    int new_cost = direct_costs0[src] + rcvdpkt->mincost[i];
    if (new_cost > INFINITY)
      new_cost = INFINITY; // جلوگیری از سرریز

    dt0.costs[i][src] = new_cost;
  }

  for (int i = 0; i < 4; i++)
  {
    if (get_min_cost0(i) != old_min_costs[i])
    {
      changed = 1;
      break;
    }
  }

  printf("t=%.3f rtupdate0: received [%d, %d, %d, %d] from node %d and mincosts %s\n",
         clocktime,
         rcvdpkt->mincost[0], rcvdpkt->mincost[1], rcvdpkt->mincost[2], rcvdpkt->mincost[3],
         src,
         changed ? "updated" : "did not update");

  printdt0(&dt0);

  if (changed)
  {
    send_dt0_to_neighbors();
  }
}

void printdt0(dtptr) struct distance_table *dtptr;

{
  printf("                via     \n");
  printf("   D0 |    1     2    3 \n");
  printf("  ----|-----------------\n");
  printf("     1|  %3d   %3d   %3d\n", dtptr->costs[1][1],
         dtptr->costs[1][2], dtptr->costs[1][3]);
  printf("dest 2|  %3d   %3d   %3d\n", dtptr->costs[2][1],
         dtptr->costs[2][2], dtptr->costs[2][3]);
  printf("     3|  %3d   %3d   %3d\n", dtptr->costs[3][1],
         dtptr->costs[3][2], dtptr->costs[3][3]);
}

void linkhandler0(linkid, newcost) int linkid, newcost;

/* called when cost from 0 to linkid changes from current value to newcost*/
/* You can leave this routine empty if you're an undergrad. If you want */
/* to use this routine, you'll need to change the value of the LINKCHANGE */
/* constant definition in prog3.c from 0 to 1 */

{
  int old_min_costs[4];
  for (int i = 0; i < 4; i++)
    old_min_costs[i] = get_min_cost0(i);

  direct_costs0[linkid] = newcost;

  for (int i = 0; i < 4; i++)
  {
    int cost_via_neighbor = neighbor_reported_costs[i][linkid];

    if (cost_via_neighbor == INFINITY)
    {
      dt0.costs[i][linkid] = INFINITY;
    }
    else
    {
      int total = newcost + cost_via_neighbor;
      if (total > INFINITY)
        total = INFINITY;
      dt0.costs[i][linkid] = total;
    }
  }

  int changed = 0;
  for (int i = 0; i < 4; i++)
  {
    if (get_min_cost0(i) != old_min_costs[i])
    {
      changed = 1;
      break;
    }
  }

  printf("t=%.3f linkhandler0: cost to link %d changed to %d. mincosts %s\n",
         clocktime, linkid, newcost, changed ? "updated" : "did not update");

  printdt0(&dt0);

  if (changed)
  {
    send_dt0_to_neighbors();
  }
}
